Class Animal {
    [string]$Name
    [string]${Diet Type}

    Animal ([string]$Name, [string]${Diet Type}) {
        $this.Name = $Name
        $this.{Diet Type} = ${Diet Type}
    }
}

$newAnimal = [animal]::new("Dog", "Carnivore"), [animal]::new("Human", "Omnivore"), [animal]::new("Rabbit", "Herbavore")
$newAnimal