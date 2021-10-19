defmodule Netrandom.IPGen do
  def gen_ip, do: gen_ip(:rand.uniform(0xD0000000) + 0xFFFFFF)

  defp gen_ip(intip)
       when intip in 0xA000000..0xAFFFFFF or
              intip in 0x64400000..0x647FFFFF or
              intip in 0x7F000000..0x7FFFFFFF or
              intip in 0xA9FE0000..0xA9FEFFFF or
              intip in 0xAC100000..0xAC1FFFFF or
              intip in 0xC0000000..0xC0000007 or
              intip in 0xC00000AA..0xC00000AB or
              intip in 0xC0000200..0xC00002FF or
              intip in 0xC0A80000..0xC0A8FFFF or
              intip in 0xC6120000..0xC613FFFF or
              intip in 0xC6336400..0xC63364FF or
              intip in 0xCB007100..0xCB0071FF or
              intip in 0xF0000000..0xFFFFFFFF do
    gen_ip()
  end

  defp gen_ip(intip) do
    <<a, b, c, d>> = <<intip::unsigned-integer-size(32)>>
    {a, b, c, d}
  end

  def infinite_ips, do: Stream.repeatedly(&gen_ip/0)
end
