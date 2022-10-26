defmodule WordleTest do
  use ExUnit.Case
    test "feedback/2 all green" do
      assert Games.Wordle.feedback("aaaaa", "aaaaa") ==
      [:green, :green, :green, :green, :green]

      assert Games.Wordle.feedback("koala", "koala") ==
      [:green, :green, :green, :green, :green]
    end

    test "feedback/2 all grey" do
      assert Games.Wordle.feedback("lapse", "quick") ==
      [:grey, :grey, :grey, :grey, :grey]
    end

    test "feedback/2 all yellow" do
      assert Games.Wordle.feedback("lapse", "alsep") ==
      [:yellow, :yellow, :yellow, :yellow, :yellow]
    end

    test "feedback/2 3 greens 2 yellows" do
      assert Games.Wordle.feedback("lapse", "lapes") ==
      [:green, :green, :green, :yellow, :yellow]
    end

    test "feedback/2 4 grays 1 yellow" do
      assert Games.Wordle.feedback("lapse", "xzwts") ==
      [:grey, :grey, :grey, :grey, :yellow]
    end

    test "feedback/2 3 grays 2 yellows" do
      assert Games.Wordle.feedback("lapse", "xzwas") ==
      [:grey, :grey, :grey, :yellow, :yellow]
    end

    test "feedback/2 3 greens 2 grays" do
      assert Games.Wordle.feedback("lapse", "lapzq") ==
      [:green, :green, :green, :grey, :grey]
    end

    test "feedback/2 2 greens 2 yellows 1 gray" do
      assert Games.Wordle.feedback("lapse", "laspw") ==
      [:green, :green, :yellow, :yellow, :grey]
    end

    test "feedback/2 excess match letters are grey" do
      assert Games.Wordle.feedback("aaaxx", "aaaax") ==
      [:green, :green, :green, :grey, :green]
    end

    describe "Benchmark tests" do
      @describetag :benchmark

      @tag timeout: 120000
      test "Benchee Tests" do
        len = 100
        long_string = String.duplicate("Z", len)
        grey1 = String.duplicate("g", len)
        grey2 = String.duplicate("b", len)


        Benchee.run(%{
          "All Green 5" => fn -> Games.Wordle.feedback("aaaaa", "aaaaa") end,
          "All Green 10" => fn -> Games.Wordle.feedback("aaaaabbbbb", "aaaaabbbbb") end,
          "All Green LONG" => fn -> Games.Wordle.feedback(long_string, long_string) end,
          "All Grey 5" => fn -> Games.Wordle.feedback("lapse", "quick") end,
          "All Grey 10" => fn -> Games.Wordle.feedback("aaaaaaaaaa", "zzzzzzzzzz") end,
          "All Grey LONG" => fn -> Games.Wordle.feedback(grey1, grey2) end
        })
      end
    end

    describe "Benchmarks 2" do
      @describetag :benchee

      @tag timeout: 120000
      test "Larger test suite" do
        Benchee.run(%{
          "All Grey" => fn -> Games.Wordle.feedback("lapse", "quick") end,
          "All Yellow" => fn -> Games.Wordle.feedback("lapse", "alsep") end,
          "3 Green 2 Yellow" => fn -> Games.Wordle.feedback("lapse", "lapes") end,
          "4 Grey 1 Yellow" => fn -> Games.Wordle.feedback("lapse", "xzwts") end,
          "3 Grey 2 Yellow" => fn -> Games.Wordle.feedback("lapse", "xzwas") end,
          "3 Green 2 Grey" => fn -> Games.Wordle.feedback("lapse", "lapzq") end
        })
      end

    end

end
