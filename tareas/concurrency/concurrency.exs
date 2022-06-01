
#Intro: Pablo Rocha, Miguel Arriaga, suma de numeros primos con concurrencia


defmodule Concurrency do

  def checkDivisible(_i,_l,1),do: 0
  def checkDivisible(i,l,n) when i > l,do: n
  def checkDivisible(i,l,n) do
    if rem(n,i) == 0 do
      0
    else
      checkDivisible(i+1,l,n)
    end
  end

  def isPrime(n) do
    checkDivisible(2,round(Float.floor(:math.sqrt(n),0)),n)
  end

  defp sumPrimesP(start,finish,sum) when start>finish, do: sum
  defp sumPrimesP(start,finish,sum),do: sumPrimesP(start,finish-1,isPrime(finish)+sum)

  defp sumPrimes(start,finish), do: sumPrimesP(start,finish,0)

  def concurrencyPrimes(n,1), do: sumPrimes(1,n)
  def concurrencyPrimes(n,threads) do
    step = round(Float.floor(n/threads,0))
    modulus = n-(step * threads)
    x= for i <- 0..threads-1 do
      if i == 0 do
        [1,(step*(i+1))+modulus-1]
      else
        if i == threads-1 do
          [(step*i)+modulus,(step*(i+1)+modulus)]
        else
          [(step*i)+modulus,(step*(i+1)+modulus-1)]
        end
      end
    end
    x
    |> Enum.map(&Task.async(fn -> sumPrimes(Enum.at(&1,0),Enum.at(&1,1)) end))
  end

end

# nums=Concurrency.concurrencyPrimes(100,4)
# IO.inspect(: :as_list)
