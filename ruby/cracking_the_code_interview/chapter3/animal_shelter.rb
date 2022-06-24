require 'minitest/autorun'

# An animal shelter, which hold only dogs and cats,
# operates on a strict 'first in, first out' basis.
# People must adopt either the 'oldest'(based on arrival time) of all animals at the shelter
# or they can select whether they would prefer a dog or cat
# (and will receive the oldest animal of that type).
# They cannot select which specific anymal they would like.
# Create the data structures to maintain this system and implement operations such as
# enqueue, dequeue_any, dequeue_dog, and dequeue_cat

class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

Cat = Class.new(Animal)
Dog = Class.new(Animal)

class Node
  attr_accessor :value, :next_value

  def initialize(value, next_value)
    @value = value
    @next_value = next_value
  end
end

class Queue # FIFO
  attr_accessor :root

  def enqueue(animal)
    if @root.nil?
      @root = Node.new(animal, nil)
    else
      node = @root

      while !node.next_value.nil?
        node = node.next_value
      end

      node.next_value = Node.new(animal, nil)
    end
  end

  def dequeue
    return if @root.nil?

    value = @root.value
    @root = @root.next_value
    value
  end

  def dequeue_by_type(type)
    return if @root.nil?

    node = @root
    previous = nil

    while !node.nil? && !node.value.is_a?(type)
      node = node.next_value
      previous = node
    end

    if !node.nil?
      if previous.nil?
        @root = node.next_value
      else
        previous.next_value = node.next_value
      end
      return node.value
    end
  end
end

class AnimalShelter
  attr_accessor :queue

  def initialize
    @queue = Queue.new
  end

  def enqueue(animal)
    @queue.enqueue(animal)
  end

  def dequeue_cat
    @queue.dequeue_by_type(Cat)
  end

  def dequeue_dog
    @queue.dequeue_by_type(Dog)
  end

  def dequeue
    @queue.dequeue
  end
end

class AnimalShelterTest < Minitest::Test
  def test_when_the_shelter_has_no_animals
    @shelter = AnimalShelter.new

    assert_nil @shelter.dequeue
  end

  def test_the_oldest_cat_is_dequeued_first
    @shelter = AnimalShelter.new

    @shelter.enqueue(Cat.new('Rob'))
    @shelter.enqueue(Cat.new('Milo'))
    @shelter.enqueue(Cat.new('Luna'))

    assert_equal @shelter.dequeue_cat.name, 'Rob'
    assert_equal @shelter.dequeue_cat.name, 'Milo'
    assert_equal @shelter.dequeue_cat.name, 'Luna'
  end

  def test_the_oldest_dog_is_dequeued_first
    @shelter = AnimalShelter.new

    @shelter.enqueue(Dog.new('Rufus'))
    @shelter.enqueue(Dog.new('Toto'))
    @shelter.enqueue(Dog.new('Pacoca'))

    assert_equal @shelter.dequeue_dog.name, 'Rufus'
    assert_equal @shelter.dequeue_dog.name, 'Toto'
    assert_equal @shelter.dequeue_dog.name, 'Pacoca'
  end

  def test_the_oldest_animal_is_dequeued_first
    @shelter = AnimalShelter.new

    @shelter.enqueue(Dog.new('Rufus'))
    @shelter.enqueue(Cat.new('Milo'))
    @shelter.enqueue(Dog.new('Pacoca'))

    assert_equal @shelter.dequeue.name, 'Rufus'
    assert_equal @shelter.dequeue.name, 'Milo'
    assert_equal @shelter.dequeue.name, 'Pacoca'
  end
end
