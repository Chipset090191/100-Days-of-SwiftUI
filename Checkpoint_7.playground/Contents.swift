import Cocoa

class Animal {
    let legs:Int = 4
    
    func greetings (){
        print ("The animal has 4 legs!")
    }
}

class Dog:Animal {
    
    func speak() {
        print ("RRRRR Gaaph Gaaph!")
    }
    
   
}

class Cat:Animal {
    var isTame:Bool
    
    init(Tame:Bool) {
        self.isTame = Tame
    }
    
    func speak() {
        print ("MEOW... MEOW... murrrr ... murrr! ")
    }
    
}

class Corgi:Dog {
    
    override func speak() {
        print ("I`m a litle Corgi fluffy boy!")
    }
}

class Poodle:Dog {
    
    override func speak() {
        print ("I`m a big sharp Poodle RRRRR!")
    }
    
}

class Persian:Cat {
    
    override func speak() {
        print ("I`m a Persian kitty!")
    }
    
}

class Lion:Cat {
    
    override func speak() {
        if isTame {
            print ("I`m a Lion who can be tamed by human!")
        } else {
            print ("I`m a CIAR of a wild animals and kill you human... RRRRRR!")
        }
    }
    
}


let corgi = Corgi()
corgi.greetings()
corgi.speak()


let lion = Lion(Tame: true)
lion.greetings()
lion.speak()
