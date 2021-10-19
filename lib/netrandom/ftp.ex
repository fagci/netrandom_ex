defmodule Netrandom.FTP do
  import Netrandom.IPGen

  def run do
    Logger.remove_backend(:console)

    infinite_ips()
    |> Task.async_stream(&check/1, max_concurrency: 2048, ordered: false, timeout: :infinity)
    |> Stream.run()
  end

  def check(ipa) do
    with {:ok, c} <- :ftp.open(ipa, timeout: 700, dtimeout: 5000) do
      with :ok <- :ftp.user(c, 'guest', 'password') do
        IO.puts(:inet_parse.ntoa(ipa))

        with {:ok, lst} <- :ftp.ls(c) do
          lst
          |> List.to_string()
          |> String.split("\n")
          |> Enum.filter(&String.length(&1))
          |> Enum.each(&IO.puts("  #{&1}"))
        end
      end

      :ftp.close(c)
    end
  end
end
