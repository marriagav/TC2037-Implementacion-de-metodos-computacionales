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
      # |>Enum.map(&hd/1)
      |> Enum.join("")
    File.write(out_file,text)
  end

  defp eachline(line) do
    a = goThroughLine(line,[])
    # IO.puts "FINAL LINE"
    # IO.inspect a
    a
  end
  defp goThroughLine("",tokens), do: Enum.reverse(tokens)
  defp goThroughLine(line,tokens) do
    cond do
      Regex.match?(~r|^[\s]+|,line)  ->
        found = Regex.run(~r|^[\s]+|,line)
        IO.inspect found
        goThroughLine(deleteFromString(line,found),[found|tokens])
      Regex.match?(~r|^"[a-zA-Z-0-9]+":|,line) ->
        found = Regex.run(~r|^"[a-zA-Z-0-9]+":|,line)
        html = "<spam class=\"object-key\">#{found}</spam>"
        goThroughLine(deleteFromString(line,found),[html|tokens])
      Regex.match?(~r|^[{}:,]|,line) ->
        found = Regex.run(~r|^[{}:,]|,line)
        html = "<spam class=\"punctuation\">#{found}</spam>"
        goThroughLine(deleteFromString(line,found),[html|tokens])
      true->
        Enum.reverse(tokens)
    end
  end

  defp deleteWS(string) when is_binary(string) do string |> String.replace(~r|\s|, "") end
  defp deleteFromString(string,rp) when is_binary(string) do string |> String.replace(rp, "") end
end

ResaltadorDeSintaxis.json_praser("json_test.txt","json.html")
