defmodule Stats do
  @moduledoc """ 
  Functions for calculating basic statistics.
  
  from *Études for Elixir*, O'Reilly Media, Inc., 2013.
  Copyright 2013 by J. David Eisenberg.
  """ 
  @vsn 0.1 

  @doc "Compute the mean of a list of numbers. Uses List.foldl/3"
  @spec mean([number]) :: number
  
  def mean(list) do
    try do
      List.foldl(list, 0, fn(x, acc) -> x + acc end) / Enum.count(list)
    rescue
      err -> err
    end
  end
  
  @doc """
  Compute the standard deviation of a list of numbers. Uses
  List.foldl/3 with a tuple as an accumulator.
  """
  @spec stdv([number]) :: number
  
  def stdv(list) do
    try do
      n = Enum.count(list)
      {sum, sum_sq} = List.foldl(list, {0,0}, fn(x, {acc, acc_sq}) ->
      {acc + x, acc_sq + x * x} end)
      :math.sqrt((n * sum_sq - sum * sum) / (n * (n - 1)))
    rescue
      err -> err
    end
  end
  
  @doc "Recursively find the minimum entry in a list of numbers."
  
  @spec minimum([number]) :: number
  
  def minimum(list) do
    try do
      [head | tail] = list
      minimum(tail, head)
    rescue
      err -> err
    end
  end
  
  # When there are no more numbers, return the result.
  
  @spec minimum([number], number) :: number
  
  defp minimum([], result) do
    result
  end
  
  # If the current result is less than the first item in the list,
  # keep it as the result and recursively look at the remainder of the list.
  # Note that you can use a variable assigned as part of a cons in a guard.
  
  defp minimum([head | tail], result) when result < head do
    minimum(tail, result)
  end
  
  # Otherwise, the head of the list becomes the new minimum,
  # and recursively look at the remainder of the list.
  
  defp minimum([head | tail], _result) do
    minimum(tail, head)
  end
  
  @doc "Recursively find the maximum entry in a list of numbers."
  @spec maximum([number]) :: number
  
  def maximum(list) do
    try do
      [head | tail] = list
      maximum(tail, head)
    rescue
      err -> err
    end
  end
  
  # When there are no more numbers, return the result.
  
  @spec maximum([number], number) :: number
  
  defp maximum([], result) do
    result
  end
  
  # If the current result is greater than the first item in the list,
  # keep it as the result and recursively look at the remainder of the list.
  
  defp maximum([head | tail], result) when result > head do
    maximum(tail, result)
  end
  
  # Otherwise, the head of the list becomes the new maximum,
  # and recursively look at the remainder of the list.
  
  defp maximum([head | tail], _result) do
    maximum(tail, head)
  end
  
  # @doc "Find the range of a list of numbers as a list [min, max]."
  @spec range([number]) :: [number]
  
  def range(list) do
    [minimum(list), maximum(list)]
  end

end
