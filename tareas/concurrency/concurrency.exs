
#Intro: Pablo Rocha, Miguel Arriaga, suma de numeros primos con concurrencia


defmodule Hw.Primes do

  # Checks if a number n is divisible by i
  defp checkDivisible(_i,_l,1),do: 0
  defp checkDivisible(i,l,n) when i > l,do: n
  defp checkDivisible(i,l,n) do
    if rem(n,i) == 0 do
      0
    else
      checkDivisible(i+1,l,n)
    end
  end

  # Returns if a number is prime
  defp isPrime(n) do
    checkDivisible(2,round(Float.floor(:math.sqrt(n),0)),n)
  end

  # Sums prime numbers in a range
  defp sumPrimesP(start,finish,sum) when start>finish, do: sum
  defp sumPrimesP(start,finish,sum),do: sumPrimesP(start,finish-1,isPrime(finish)+sum)

  @doc """
  Function to calculate the sum of primes
  """
  def sum_primes(start,finish), do: sumPrimesP(start,finish,0)
  def sum_primes(finish), do: sumPrimesP(1,finish,0)

  @doc """
  Function to divide the tasks in different threads and calculate the sum of primes
  """
  def sum_primes_parallel(n,1), do: sum_primes(1,n)
  def sum_primes_parallel(n,threads) do
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
    |> Enum.map(&Task.async(fn -> sum_primes(Enum.at(&1,0),Enum.at(&1,1)) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()
  end

  @doc """
  Function to meassure execution time
  """
  def meassure_time(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
    |> IO.inspect()
  end

end

#Quick test
#Without concurrency
Hw.Primes.meassure_time(fn -> Hw.Primes.sum_primes(100000) end)
#With concurrency
Hw.Primes.meassure_time(fn -> Hw.Primes.sum_primes_parallel(100000,5) end)
