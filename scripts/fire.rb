# Is the internet on fire?
module Internet
  def self.onfire
    require 'json'
    require 'net/http'
    result = JSON.parse(Net::HTTP.get(URI('https://istheinternetonfire.com/status.json')))
    message = ":fire: *#{result['status']}*\n"
    result['issues'].each do |issue|
      message += "\t:point_right: #{issue['txt']}\n"
      message += "\tCVE(s) : #{issue['cves'].join(', ')}\n" unless issue['cves'].empty?
      message += "\tReference: #{issue['urls'].join(', ')}\n" unless issue['urls'].empty?
    end
    <<-HEREDOC
        #{message}
    HEREDOC
  end
end
