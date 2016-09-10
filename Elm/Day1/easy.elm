product list = List.foldl (*) 1 list
product [2,4,5]

point = {x=5,y=4}
points = [{x=2,y=1},{x=9,y=8},{x=6,y=5}]
getX pt = pt.x
getX point
getXList list = List.map getX list
getXList points

person = {name="Alice",age=Just 10,address={blk=14,street="wonder st"}}

multiply a b = a * b
(multiply 6) 8

person2 = {name="Bob",age=Just 18,address={blk=15,street="england st"}}
person3 = {name="Candy",age=Just 40,address={blk=24,street="sweet land"}}
person4 = {name="Dan",age=Nothing,address={blk=88,street="amk"}}
persons = [person,person2,person3,person4]
getAge p = p.age
findabove16 list = List.filter (\p -> p.age > 16) list
findabove16 persons

above16adv list = List.filter (\p -> \
    case p.age of \
        Just a -> a > 16 \
        Nothing -> False \
    ) list
above16adv persons