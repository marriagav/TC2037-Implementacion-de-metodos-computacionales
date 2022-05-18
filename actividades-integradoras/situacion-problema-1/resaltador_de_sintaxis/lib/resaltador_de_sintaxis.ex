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
  def json_praser(in_filename,out_file,template_html) do
    text =
      in_filename
      |>File.stream!()
      |>Enum.map(&eachline/1)
      |>Enum.filter(fn x -> x !== nil end)
      |>Enum.join("")
    finaltext =
      File.read!(template_html)
      |>String.replace("~a",text)
    File.write(out_file,finaltext)
  end

  #Function that calls goThroughLine for each line
  defp eachline(line) do
    goThroughLine(line,[])

  end

  #Function that identifies the tolkens of a line and returns them in html format
  defp goThroughLine("",tokens), do: Enum.reverse(tokens)
  defp goThroughLine(line,tokens) do
    cond do
      Regex.match?(~r|^[\s]+|,line)  ->
        found = Regex.run(~r|^[\s]+|,line)
        goThroughLine(deleteWS(line),[found|tokens])

      Regex.match?(~r|^"[a-zA-Z-0-9]+"[\s]*:|,line) ->
        found = Regex.run(~r|^"[a-zA-Z-0-9]+"[\s]*:|,line)
        withoutPunct=hd(found)
        withoutPunct=deleteFromString(withoutPunct,":")
        html = "<spam class=\"object-key\">#{withoutPunct}</spam>"
        goThroughLine(deleteFromString(line,[withoutPunct]),[html|tokens])

      Regex.match?(~r|^".+"|,line) ->
        found = Regex.run(~r|^".+"|,line)
        html = "<spam class=\"string\">#{found}</spam>"
        goThroughLine(deleteFromString(line,found),[html|tokens])

      Regex.match?(~r|^[-\|+]?[\d.]+(?:[e\|E]-?\d+)?|,line) ->
        found = Regex.run(~r|^[-\|+]?[\d.]+(?:[e\|E]-?\d+)?|,line)
        html = "<spam class=\"number\">#{found}</spam>"
        goThroughLine(deleteFromString(line,found),[html|tokens])

      Regex.match?(~r|^\btrue\b\|^\bnull\b\|^\bfalse\b|,line) ->
        found = Regex.run(~r|^\btrue\b\|^\bnull\b\|^\bfalse\b|,line)
        html = "<spam class=\"reserved-word\">#{found}</spam>"
        goThroughLine(deleteFromString(line,found),[html|tokens])

      Regex.match?(~r|^[{}:,\[\]]|,line) ->
        found = Regex.run(~r|^[{}:,\[\]]*|,line)
        html = "<spam class=\"punctuation\">#{found}</spam>"
        goThroughLine(deleteFromString(line,found),[html|tokens])

      true->
        Enum.reverse(tokens)
    end
  end


  #Function that deletes rp value from a string
  defp deleteFromString(string,rp) when is_binary(string) do string |> String.replace(rp, "") end
  defp deleteWS(string), do: String.trim_leading(string)
end

# ResaltadorDeSintaxis.json_praser("./test_json_files/json_test.json","./html_output_files/json_test.html","template_page.html")
