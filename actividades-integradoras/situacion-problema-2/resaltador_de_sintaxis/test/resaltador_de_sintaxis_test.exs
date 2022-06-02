defmodule ResaltadorDeSintaxisTest do
  use ExUnit.Case
  doctest ResaltadorDeSintaxis

  test "Parses json files" do
    # With concurrency:
    ResaltadorDeSintaxis.meassure_time(fn -> ResaltadorDeSintaxis.multi_parser("./lib/test_json_files/*.json","./lib/template_page.html") end)
    # Without concurrency:
    ResaltadorDeSintaxis.meassure_time(fn -> ResaltadorDeSintaxis.single_parser("./lib/test_json_files/*.json","./lib/template_page.html") end)
  end
end
