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
    regex_space = ~r|^[\s]+|
    regex_keys = ~r|^"[^,]+?(?=["])"[\s]*:|
    regex_string = ~r|^".*?(?=["])"|
    regex_numbers = ~r|^[-\|+]?[\d.]+(?:[e\|E]-?\d+)?|
    regex_reserved = ~r|^\btrue\b\|^\bnull\b\|^\bfalse\b|
    regex_punctuation = ~r|^[{}:,\[\]]|
    cond do
      #Look for spaces and trim
      Regex.match?(regex_space,line)  ->
        found = Regex.run(regex_space,line)
        goThroughLine(deleteWS(line),[found|tokens])
      #Regex for keys
      Regex.match?(regex_keys,line) ->
        found = Regex.run(regex_keys,line)
        withoutPunct=hd(found)
        withoutPunct=deletePunctFromKey(withoutPunct)
        html = "<spam class=\"object-key\">#{withoutPunct}</spam>"
        goThroughLine(deleteFromString(line,withoutPunct),[html|tokens])
      #Regex for strings
      Regex.match?(regex_string,line) ->
        found = Regex.run(regex_string,line)
        html = "<spam class=\"string\">#{found}</spam>"
        goThroughLine(deleteFromString(line,hd(found)),[html|tokens])
      #Regex for numbers
      Regex.match?(regex_numbers,line) ->
        found = Regex.run(regex_numbers,line)
        html = "<spam class=\"number\">#{found}</spam>"
        goThroughLine(deleteFromString(line,hd(found)),[html|tokens])
      #Regex for reserved words
      Regex.match?(regex_reserved,line) ->
        found = Regex.run(regex_reserved,line)
        html = "<spam class=\"reserved-word\">#{found}</spam>"
        goThroughLine(deleteFromString(line,hd(found)),[html|tokens])
      #Regex for puntuation
      Regex.match?(regex_punctuation,line) ->
        found = Regex.run(regex_punctuation,line)
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
