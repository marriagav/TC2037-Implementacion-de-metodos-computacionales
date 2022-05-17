# Pablo Rocha
# Miguel Arriaga
# 17/05/2022

defmodule ResaltadorDeSintaxis do
  @moduledoc """
  Module to parse a json file into an HTML
  """

  @doc """
  Function that reads and maps the JSON file
  """
  def json_praser(in_filename,out_file) do
    text =
      in_filename
      |>File.stream!()
      |>Enum.map(&eachline/1)
      |>Enum.filter(fn x -> x !== nil end)
      |>Enum.join("")
    File.write(out_file,text)
  end

  #Function that calls goThroughLine for each line
  defp eachline(line) do
    a = goThroughLine(line,[])
    a
  end

  #Function that identifies the tolkens of a line and returns them in html format
  defp goThroughLine("",tokens), do: Enum.reverse(tokens)
  defp goThroughLine(line,tokens) do
    cond do
      Regex.match?(~r|^[\s]+|,line)  ->
        found = Regex.run(~r|^[\s]+|,line)
        goThroughLine(deleteFromString(line,found),[found|tokens])
      Regex.match?(~r|^"[a-zA-Z-0-9]+":|,line) ->
        found = Regex.run(~r|^"[a-zA-Z-0-9]+":|,line)
        withoutPunct=hd(found)
        withoutPunct=deleteFromString(withoutPunct,":")
        html = "<spam class=\"object-key\">#{withoutPunct}</spam>"
        goThroughLine(deleteFromString(line,[withoutPunct]),[html|tokens])
      Regex.match?(~r|^[{}:,]|,line) ->
        found = Regex.run(~r|^[{}:,]|,line)
        html = "<spam class=\"punctuation\">#{found}</spam>"
        goThroughLine(deleteFromString(line,found),[html|tokens])
      true->
        Enum.reverse(tokens)
    end
  end

  #Function that deletes rp value from a string
  defp deleteFromString(string,rp) when is_binary(string) do string |> String.replace(rp, "") end
end

ResaltadorDeSintaxis.json_praser("json_test.txt","json.html")
