defmodule ResaltadorDeSintaxisTest do
  use ExUnit.Case
  doctest ResaltadorDeSintaxis

  test "Parses json files" do
    ResaltadorDeSintaxis.json_praser("./lib/json_test.txt","./lib/json.html")
  end
end
