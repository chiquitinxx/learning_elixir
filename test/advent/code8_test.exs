defmodule Code8Test do
    use ExUnit.Case
  
    test "calculate tree metadata" do
      assert Code8.sum_metadata("2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2") == 138
    end
  
    test "calculate tree metadata hardest" do
        assert Code8.sum_metadata("2 3 2 2 0 1 6 0 1 7 4 5 3 2 0 1 6 0 1 7 0 1 11 4 5 1 1 2") == 59
    end

    test "calculate advent 8 input" do
        assert Code8.sum_metadata(File.read!("test/advent/code8input")) == 45868
    end

  end