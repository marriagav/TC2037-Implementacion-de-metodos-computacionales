defmodule ResaltadorDeSintaxisTest do
  use ExUnit.Case
  doctest ResaltadorDeSintaxis

  test "Parses json files" do
    ResaltadorDeSintaxis.json_praser("./lib/test_json_files/json_test.json","./lib/html_output_files/json_test.html","./lib/template_page.html")
    ResaltadorDeSintaxis.json_praser("./lib/test_json_files/example_0.json","./lib/html_output_files/html_0.html","./lib/template_page.html")
    ResaltadorDeSintaxis.json_praser("./lib/test_json_files/example_1.json","./lib/html_output_files/html_1.html","./lib/template_page.html")
    ResaltadorDeSintaxis.json_praser("./lib/test_json_files/example_2.json","./lib/html_output_files/html_2.html","./lib/template_page.html")
    ResaltadorDeSintaxis.json_praser("./lib/test_json_files/example_3.json","./lib/html_output_files/html_3.html","./lib/template_page.html")
    ResaltadorDeSintaxis.json_praser("./lib/test_json_files/example_4.json","./lib/html_output_files/html_4.html","./lib/template_page.html")
    ResaltadorDeSintaxis.json_praser("./lib/test_json_files/example_5.json","./lib/html_output_files/html_5.html","./lib/template_page.html")
  end
end
