#Ignore the long url, please.
module QR
  def self.generate(data)
    require 'shorturl'
    textQR = 'https://energon.cloud'
    if match = data.match(/qr (.*?)$/i)
      textQR = match.captures[0]
    end
    link = "https://qr-generator.qrcode.studio/qr/custom?download=true&file=png&data=#{textQR}&size=1000&config=%7B%22body%22%3A%22square%22%2C%22eye%22%3A%22frame0%22%2C%22eyeBall%22%3A%22ball0%22%2C%22erf1%22%3A%5B%5D%2C%22erf2%22%3A%5B%5D%2C%22erf3%22%3A%5B%5D%2C%22brf1%22%3A%5B%5D%2C%22brf2%22%3A%5B%5D%2C%22brf3%22%3A%5B%5D%2C%22bodyColor%22%3A%22%23000000%22%2C%22bgColor%22%3A%22%23FFFFFF%22%2C%22eye1Color%22%3A%22%23000000%22%2C%22eye2Color%22%3A%22%23000000%22%2C%22eye3Color%22%3A%22%23000000%22%2C%22eyeBall1Color%22%3A%22%23000000%22%2C%22eyeBall2Color%22%3A%22%23000000%22%2C%22eyeBall3Color%22%3A%22%23000000%22%2C%22gradientColor1%22%3A%22%23000000%22%2C%22gradientColor2%22%3A%22%23D821C3%22%2C%22gradientType%22%3A%22linear%22%2C%22gradientOnEyes%22%3A%22true%22%2C%22logo%22%3A%2249ed47edca6e827cb77424b4bcc1877e46a5b1a6.png%22%2C%22logoMode%22%3A%22default%22%7D"
    short = ShortURL.shorten(link, :tinyurl).match(/http:..(.*?)$/i)
    "Download your QR at #{short.captures[0]}"
  end
end