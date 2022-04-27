
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
    if tail == [] do
      Enum.reverse([n|[head|before]])
    else
      if n <= head  do
        Enum.reverse(do_join([head | tail],[n|before]))
      else
        do_insert(n,[head | before],tail)
      end
    end
  end

  def insertion_sort(list), do: do_insertion_sort([],list)
  defp do_insertion_sort(sorted,[]),do: sorted
  defp do_insertion_sort(sorted,[head | tail]),do: do_insertion_sort(insert(head,sorted),tail)
end

# IO.inspect Homework.insert(4,[])
# IO.inspect Homework.insert(4,[1,2,5])
# IO.inspect Homework.insert(6,[3,4])
IO.inspect Homework.insertion_sort([4,3,6,8,3,0,9,1,7])
