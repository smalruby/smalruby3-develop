require "uri"
require "net/http"
require "cgi"
require "json"
require "base64"

ALLOW_ORIGINS = %w(
  https://smalruby.app
  https://smalruby.jp
  http://localhost:8601
)

def lambda_handler(event:, context:)
  origin = event.dig("headers", "origin").to_s.strip
  headers = {
    "Access-Control-Allow-Origin": ALLOW_ORIGINS.include?(origin) ? origin : ALLOW_ORIGINS.first,
    "Access-Control-Allow-Headers": "Content-Type",
    "Access-Control-Allow-Methods": "OPTIONS,GET"
  }

  url = event.dig("queryStringParameters", "url").to_s.strip
  if url.length == 0
    return {
      statusCode: 400,
      headers:,
      body: {
        code: "Bad Request",
        message: "invalid url",
      }.to_json,
      isBase64Encoded: false
    }
  end

  begin
    # Google DriveのURLを直接ダウンロード可能な形式に変換
    download_url = convert_google_drive_url(url)

    res = fetch_content(download_url)
    response = {
      statusCode: res[:status],
      headers: headers.merge(res[:headers]),
      body: res[:body]
    }

    # バイナリデータの場合はisBase64Encodedフラグを設定
    response[:isBase64Encoded] = res[:isBase64Encoded] if res.key?(:isBase64Encoded)

    response
  rescue => e
    {
      statusCode: 500,
      headers:,
      body: {
        code: "Internal Server Error",
        message: e.message
      }.to_json,
      isBase64Encoded: false
    }
  end
end

def convert_google_drive_url(url)
  # Google DriveのファイルIDを抽出
  file_id = extract_google_drive_file_id(url)

  if file_id
    # 直接ダウンロード可能なURLに変換
    return "https://drive.google.com/uc?export=download&id=#{file_id}"
  end

  # Google Drive URLでない場合はそのまま返す
  url
end

def extract_google_drive_file_id(url)
  # パターン1: https://drive.google.com/file/d/FILE_ID/view
  if match = url.match(/drive\.google\.com\/file\/d\/([a-zA-Z0-9_-]+)/)
    return match[1]
  end

  # パターン2: https://drive.google.com/open?id=FILE_ID
  if match = url.match(/drive\.google\.com\/open\?id=([a-zA-Z0-9_-]+)/)
    return match[1]
  end

  # パターン3: 既に uc?export=view&id=FILE_ID の形式
  if match = url.match(/drive\.google\.com\/uc\?.*id=([a-zA-Z0-9_-]+)/)
    return match[1]
  end

  nil
end

def fetch_content(url)
  uri = URI.parse(url)

  unless %w[http https].include?(uri.scheme)
    raise "Invalid URL scheme: #{uri.scheme}"
  end

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == 'https')
  http.read_timeout = 30
  http.open_timeout = 10

  request = Net::HTTP::Get.new(uri.request_uri)
  request['User-Agent'] = 'Mozilla/5.0 (compatible; AWS-Lambda-Proxy/1.0)'

  response = http.request(request)

  case response.code.to_i
  when 200..299
    # 成功レスポンス
    content_type = response['content-type'] || 'application/octet-stream'

    # Content-Typeからバイナリかテキストかを判定
    is_binary = is_binary_content?(content_type)

    if is_binary
      # バイナリデータの場合はBase64エンコードしてisBase64Encodedフラグを設定
      {
        status: 200,
        headers: { 'Content-Type' => content_type },
        body: Base64.strict_encode64(response.body),
        isBase64Encoded: true
      }
    else
      # テキストデータの場合はそのまま
      {
        status: 200,
        headers: { 'Content-Type' => content_type },
        body: response.body.force_encoding("utf-8"),
        isBase64Encoded: false
      }
    end
  when 300..399
    # リダイレクトの場合 - Google Driveでよく発生
    location = response['location']
    if location
      # リダイレクト先を再帰的に取得（1回のみ）
      fetch_content(location)
    else
      raise "Redirect without location header"
    end
  else
    # エラーレスポンス
    {
      status: response.code.to_i,
      headers: {},
      body: {
        code: "HTTP Error",
        message: "HTTP #{response.code}: #{response.message}"
      }.to_json,
      isBase64Encoded: false
    }
  end
end

def is_binary_content?(content_type)
  # バイナリと判定するContent-Type
  binary_types = [
    'image/',
    'video/',
    'audio/',
    'application/pdf',
    'application/zip',
    'application/gzip',
    'application/x-tar',
    'application/x-rar-compressed',
    'application/x-7z-compressed',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument',
    'application/msword',
    'application/vnd.ms-powerpoint',
    'application/octet-stream'
  ]

  # テキストと判定するContent-Type
  text_types = [
    'text/',
    'application/json',
    'application/xml',
    'application/javascript',
    'application/x-javascript'
  ]

  content_type_lower = content_type.downcase

  # まずテキストタイプをチェック
  return false if text_types.any? { |type| content_type_lower.start_with?(type) }

  # 次にバイナリタイプをチェック
  return true if binary_types.any? { |type| content_type_lower.start_with?(type) }

  # 不明な場合はバイナリとして扱う（安全側に倒す）
  true
end

image/
video/
audio/
application/pdf
application/zip
application/gzip
application/x-tar
application/x-rar-compressed
application/x-7z-compressed
application/vnd.ms-excel
application/vnd.openxmlformats-officedocument
application/msword
application/vnd.ms-powerpoint
application/octet-stream
