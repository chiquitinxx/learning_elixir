defmodule Code13Test do
    use ExUnit.Case

    test "read track" do
        {:ok, readed_track} = Code13.read_track(File.read!("test/advent/code13input"))
        assert Enum.count(readed_track) == 150
        assert Code13.track_at(readed_track, {2, 0}) == "/"
        assert Code13.track_at(readed_track, {37, 0}) == "\\"
        assert Code13.track_at(readed_track, {27, 5}) == "<"
    end

    test "extract arrows" do
        easy_track = ["| < > v ^ - +", " < "]
        {track, arrows} = Code13.extract_arrows(easy_track)
        assert track == ["| - - | | - +", " - "]
        assert arrows == [
            %{position: {2, 0}, direction: :left, turn: :left},
            %{position: {4, 0}, direction: :right, turn: :left},
            %{position: {6, 0}, direction: :down, turn: :left},
            %{position: {8, 0}, direction: :up, turn: :left},
            %{position: {1, 1}, direction: :left, turn: :left}
        ]
    end

    test "move forward" do
        arrow = %{position: {2, 0}, direction: :left, turn: :left }
        %{position: position, direction: direction, turn: turn } = Code13.move_arrow(arrow, "-")
        assert position == {1, 0}
        assert direction == :left
        assert turn == :left
    end

    test "normal turn" do
        arrow = %{position: {2, 0}, direction: :left, turn: :left }
        %{position: position, direction: direction, turn: turn } = Code13.move_arrow(arrow, "/")
        assert position == {2, 1}
        assert direction == :down
        assert turn == :left
    end

    test "intersection" do
        arrow = %{position: {2, 0}, direction: :left, turn: :left }
        arrow = Code13.move_arrow(arrow, "+")
        arrow = Code13.move_arrow(arrow, "+")
        arrow = Code13.move_arrow(arrow, "+")
        %{position: position, direction: direction, turn: turn } = Code13.move_arrow(arrow, "+")
        assert position == {1, 3}
        assert direction == :down
        assert turn == :straight
    end

    test "move arrows" do
        first_arrow = %{position: {0, 0}, direction: :right, turn: :left }
        second_arrow = %{position: {3, 0}, direction: :left, turn: :left }
        {:ok, moved_arrows } = Code13.move_arrows([first_arrow, second_arrow], ["-----"])
        {:crash, {x, y} } = Code13.move_arrows(moved_arrows, ["-----"])
        assert x == 2
        assert y == 0
    end

    test "play full track" do
        {:ok, readed_track} = Code13.read_track(File.read!("test/advent/code13input"))
        {track, arrows} = Code13.extract_arrows(readed_track)
        {x, y} = Code13.find_first_crash(track, arrows)
        assert x == 123
        assert y == 18
    end

    #@tag timeout: 1000000
    test "find last up" do
        {:ok, readed_track} = Code13.read_track(File.read!("test/advent/code13input"))
        {track, arrows} = Code13.extract_arrows(readed_track)
        arrow = Code13b.find_last_up(track, arrows)
        assert arrow.position == {71, 123}
    end

  end
  