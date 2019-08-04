## Questões

As questões devem ser respondidas com queries do `ActiveRecord`.
Inclua os trechos de código que respondem as perguntas abaixo:

### Qual é o custo médio dos animais do tipo cachorro?

```
Animal.joins(:animal_type)
  .where(animal_types: { name: 'Cachorro' })
  .then { |animal| animal.sum(&:monthly_cost) / animal.length }
  .to_f
```

### Quantos cachorros existem no sistema?

```
Animal.joins(:animal_type)
  .where(animal_types: { name: 'Cachorro' })
  .count
```

### Qual o nome dos donos dos cachorros (Array de nomes)

```
Person.joins(animals: :animal_type)
  .where(animal_types: { name: 'Cachorro' })
  .pluck(:name)
```

### Retorne as pessoas ordenando pelo custo que elas tem com os animais (Maior para menor)

```
Person.eager_load(:animals)
  .sort_by { |person| person.animals.sum(&:monthly_cost) }
  .reverse
```

### Levando em consideração o custo mensal, qual será o custo de 3 meses de cada pessoa?

```
Person.eager_load(:animals)
  .sort_by { |person| person.animals.sum(&:monthly_cost) }
  .reverse
  .map do |person|
  [person, (person.animal_monthly_cost * 3).to_f]
end
```
