# Problemario: Programación funcional, parte 2
# Miguel Arriaga
# Pablo Rocha
# 2022-29-04


defmodule Hw.Ariel2 do
  @moduledoc"""
  Functions to work with lists in elixir
  """

  @doc"""
  Function to merge lists quickly
  """
  def joinLists(list1,list2),do: do_join(list1,list2)
  defp do_join([],list2),do: list2
  defp do_join([head|tail],list2), do: do_join(tail,[head | list2])

  @doc"""
  #1 insert: Unir un elemento en el lugar adecuado
  """
  #! Marca errores en los tests
  def insert(n,list),do: do_insert(n,[],list)
  defp do_insert(n,[],[]),do: [n]
  defp do_insert(n,before,[head | tail]) do
      if n <= head  do
        Enum.reverse(do_join([head | tail],[n|before]))
      else
        if tail == [] do
          Enum.reverse([n|[head|before]])
        else
        do_insert(n,[head | before],tail)
      end
    end
  end

  @doc"""
  #2 Insertion Sort
  """
  def insertion_sort(list), do: do_insertion_sort([],list)
  defp do_insertion_sort(sorted,[]),do: sorted
  defp do_insertion_sort(sorted,[head | tail]),do: do_insertion_sort(insert(head,sorted),tail)

  @doc"""
  #3 Rotate left
  """
  def rotate_left(n,list), do: do_rotate_left(n,list)
  defp do_rotate_left(0,list),do: list
  defp do_rotate_left(n,[]),do: []
  defp do_rotate_left(n,[head|tail])when n > 0, do: do_rotate_left(n-1,tail++[head])
  defp do_rotate_left(n,list)when n < 0, do: do_rotate_left(n+1,List.delete_at([List.last(list)|list], length([List.last(list)|list])-1))

  # @doc"""
  # #4 Prime Helper
  # """
  # def prime_helper(n), do: do_prime_helper(2,n)
  # defp do_prime_helper(p,n) do
  #   p_rounded=Kernel.trunc(p)
  #   if rem(n, p_rounded) == 0 do
  #     p
  #   else
  #     do_prime_helper(p_rounded+1,n)
  #   end
  # end


  # @doc"""
  # #4 Prime Factors
  # """
  # def prime_factors(n), do: do_prime_factors(n,[])
  # defp do_prime_factors(left,res) when left < 2,do: Enum.reverse(res)
  # defp do_prime_factors(left,list) when left >= 2 do
  #   min = prime_helper(left)
  #   do_prime_factors(left/min,[min|list])
  # end

  # @doc"""
  # #8 Group contiguous equal elements in a list as sublists
  # """
  # def pack(list), do: do_pack(list, [], [])
  # defp do_pack([], _temp, result), do: Enum.reverse(result)
  # # The list only has one element
  # defp do_pack([head | []], temp, result),
  #   do: do_pack([], [], [[head | temp] | result])
  # # The first two elements are equal
  # defp do_pack([head, head | tail], temp, result),
  #   do: do_pack([head | tail], [head | temp], result)
  # # The first two elements are different
  # defp do_pack([head | tail], temp, result),
  #   do: do_pack(tail, [], [[head | temp] | result])

end

# ! Testing
# IO.inspect Hw.Ariel2.insert(4,[])
# IO.inspect Hw.Ariel2.insert(4,[1,2,5])
# IO.inspect Hw.Ariel2.insert(6,[3,4])
# IO.inspect Hw.Ariel2.insertion_sort([4,3,6,8,3,0,9,1,7])
# IO.inspect Hw.Ariel2.insertion_sort([5,5,5,1,5,5,5])
# IO.inspect Hw.Ariel2.rotate_left(3,[4,3,6,8,3,0,9,1,7])
# IO.inspect Hw.Ariel2.rotate_left(-1,[4,3,6,8,3,0,9,1,7])
# IO.inspect Hw.Ariel2.prime_factors(12)
