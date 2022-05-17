defmodule ResaltadorDeSintaxis do
  @moduledoc """
  Documentation for `ResaltadorDeSintaxis`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ResaltadorDeSintaxis.hello()
      :world

  """
  def json_praser(in_filename,out_file) do
    text =
      in_filename
      |>File.stream!()
      |>Enum.map(&eachline/1)
      |>Enum.filter(fn x -> x !== nil end)
      |>Enum.map(&hd/1)
      |> Enum.join("\n")
    File.write(out_file,text)
  end

  defp eachline(line) do
    withoutabs = deleteWS(line)
    # IO.inspect withoutabs
    # Regex.run(~r|^[{}:,""]|,withoutabs)
    # Regex.run(~r|\t|,line)
    # Regex.run(~r|^[{}:,""]|,line)
    goThroughLine(line,[])
  end
  defp goThroughLine("",tokens), do: Enum.reverse(tokens)
  defp goThroughLine(line,tokens) do
    IO.inspect tokens
    if Regex.match?(~r|^\s|,line) do
      found = Regex.run(~r|^\s|,line)
      goThroughLine(deleteFromString(line,found),[found|tokens])
    end
    if Regex.match?(~r|^[{}:,""]|,line) do
      found = Regex.run(~r|^[{}:,""]|,line)
      IO.puts "AQUI"
      IO.inspect found
      goThroughLine(deleteFromString(line,found),[found|tokens])
    end
  end

  defp deleteWS(string) when is_binary(string) do string |> String.replace(~r|\s|, "") end
  defp deleteFromString(string,rp) when is_binary(string) do string |> String.replace(rp, "") end
end

ResaltadorDeSintaxis.json_praser("json_test.txt","json.html")
