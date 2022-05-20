# Pablo Rocha
# Miguel Arriaga
# 17/05/2022

defmodule ResaltadorDeSintaxis do
  @moduledoc """
  Module to parse a json file into an HTML
  """

  @doc """
  Main function that reads and maps the JSON file
  """
  def json_praser(in_filename,out_file,template_html) do
    text =
      in_filename
      |>File.stream!()
      |>Enum.map(&eachline/1)
      |>Enum.filter(fn x -> x !== nil end)
      |>Enum.join("")
    # Get the time
    d = DateTime.utc_now
    s = "#{d.year}/#{d.month}/#{d.day}"
    #Replace time and tokens in template
    finaltext =
      File.read!(template_html)
      |>String.replace("~a",text)
      |>String.replace("~d",s)
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
      #Look for spaces and trim
      Regex.match?(~r|^[\s]+|,line)  ->
        found = Regex.run(~r|^[\s]+|,line)
        goThroughLine(deleteWS(line),[found|tokens])
      #Regex for keys
      Regex.match?(~r|^"[^,]+?(?=["])"[\s]*:|,line) ->
        found = Regex.run(~r|^"[^,]+?(?=["])"[\s]*:|,line)
        withoutPunct=hd(found)
        withoutPunct=deletePunctFromKey(withoutPunct)
        html = "<spam class=\"object-key\">#{withoutPunct}</spam>"
        goThroughLine(deleteFromString(line,withoutPunct),[html|tokens])
      #Regex for strings
      Regex.match?(~r|^".*?(?=["])"|,line) ->
        found = Regex.run(~r|^".*?(?=["])"|,line)
        html = "<spam class=\"string\">#{found}</spam>"
        goThroughLine(deleteFromString(line,hd(found)),[html|tokens])
      #Regex for numbers
      Regex.match?(~r|^[-\|+]?[\d.]+(?:[e\|E]-?\d+)?|,line) ->
        found = Regex.run(~r|^[-\|+]?[\d.]+(?:[e\|E]-?\d+)?|,line)
        html = "<spam class=\"number\">#{found}</spam>"
        goThroughLine(deleteFromString(line,hd(found)),[html|tokens])
      #Regex for reserved words
      Regex.match?(~r|^\btrue\b\|^\bnull\b\|^\bfalse\b|,line) ->
        found = Regex.run(~r|^\btrue\b\|^\bnull\b\|^\bfalse\b|,line)
        html = "<spam class=\"reserved-word\">#{found}</spam>"
        goThroughLine(deleteFromString(line,hd(found)),[html|tokens])
      #Regex for puntuation
      Regex.match?(~r|^[{}:,\[\]]|,line) ->
        found = Regex.run(~r|^[{}:,\[\]]*|,line)
        html = "<spam class=\"punctuation\">#{found}</spam>"
        goThroughLine(deleteFromString(line,hd(found)),[html|tokens])
      #Base case
      true->
        Enum.reverse(tokens)
    end
  end


  #Function that deletes rp value from a string
  defp deleteFromString(string,rp) , do: String.trim_leading(string, rp)
  defp deleteWS(string), do: String.trim_leading(string)
  defp deletePunctFromKey(string), do: String.trim_trailing(string, ":")
end

# Quick test
# ResaltadorDeSintaxis.json_praser("./test_json_files/json_test.json","./html_output_files/json_test.html","template_page.html")
