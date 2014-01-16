class SortedArray
  attr_reader :internal_arr

  def initialize(arr=[])
    @internal_arr = []
    arr.each { |el| add el }
  end

  def add(el)
    # we are going to keep this array
    # sorted at all times. so this is ez
    lo = 0
    hi = @internal_arr.size
    # note that when the array just
    # starts out, it's zero size, so
    # we don't do anything in the while
    # otherwise this loop determines
    # the position in the array, *before*
    # which to insert our element
    while lo < hi
      # let's get the midpoint
      mid = (lo + hi) / 2
      if @internal_arr[mid] < el
        # if the middle element is less 
        # than the current element
        # let's increment the lo by one
        # from the current midway point
        lo = mid + 1
      else
        # otherwise the hi *is* the midway 
        # point, we'll take the left side next
        hi = mid 
      end
    end

    # insert at the lo position
    @internal_arr.insert(lo, el)
  end

  def each(&block)
    # raise NotImplementedError.new("You need to implement the each method!")
    index = 0
    while index < @internal_arr.size
      yield(@internal_arr[index])
      index += 1
    end
    return @internal_arr
  end

  def map(&block)
    # raise NotImplementedError.new("You need to implement the map method!")
    new_array = []
    each do |element|
      new_array << yield(element)
    end
    return new_array
  end

  def map!(&block)
    # raise NotImplementedError.new("You need to implement the map! method!")
    index = 0
    each do |element|
      @internal_arr[index] = yield(element)
      index += 1
    end
    return @internal_arr
  end

  def find(&block)
    # raise NotImplementedError.new("You need to implement the find method!")
    index = 0
    while index < @internal_arr.size
      return @internal_arr[index] if yield(@internal_arr[index])
      index += 1
    end
    return nil  

  end

  def inject(acc=nil, &block)
    # raise NotImplementedError.new("You need to implement the inject method!")
    each do |element|
      if acc.nil?
        acc = @internal_arr[0]
      else
        acc = yield(acc,element)
      end
    end
    return acc

  end

end
