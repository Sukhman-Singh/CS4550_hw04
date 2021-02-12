defmodule Practice.Factor do
  def parse_int(text) when is_integer(text) do
    text
  end

  def parse_int(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def factor(x) do
    x
    |> parse_int()
    |> findFactors([])
    |> Enum.join(" ")
  end

  def findFactors(x, acc) do
    if (x === 1) do
      acc
    else
      findFactors(div(x, findSmallestFactor(x, 2)), [findSmallestFactor(x, 2)] ++ acc)
    end
  end

  def findSmallestFactor(x, acc) do
    if (rem(x, acc) === 0) do
      acc
    else
      findSmallestFactor(x, (acc + 1))
    end
  end

end
