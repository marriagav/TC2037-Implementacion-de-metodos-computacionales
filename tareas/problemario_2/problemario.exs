
# Intro: Pablo Rocha y Miguel Arriaga

defmodule Homework do
  # Exp: function to merge list quickly
  def joinLists(list1,list2),do: do_join(list1,list2)
  defp do_join([],list2),do: list2
  defp do_join([head|tail],list2), do: do_join(tail,[head | list2])

  # Ejercicio: Unir un elemento en el lugar adecuado
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

  def insertion_sort(list), do: do_insertion_sort([],list)
  defp do_insertion_sort(sorted,[]),do: sorted
  defp do_insertion_sort(sorted,[head | tail]),do: do_insertion_sort(insert(head,sorted),tail)

  def rotate_left(n,list), do: do_rotate_left(n,list)
  defp do_rotate_left(0,list),do: list
  defp do_rotate_left(n,[head|tail]) do
    #!Poner codigo para rotar
    do_rotate_left(n-1,list)
  end
end

IO.inspect Homework.insert(4,[])
IO.inspect Homework.insert(4,[1,2,5])
IO.inspect Homework.insert(6,[3,4])
IO.inspect Homework.insertion_sort([4,3,6,8,3,0,9,1,7])
IO.inspect Homework.insertion_sort([5,5,5,1,5,5,5])
