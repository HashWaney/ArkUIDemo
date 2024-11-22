class Animal {
  name:string;
  type:string;
  age: number;

  constructor(name:string, type:string, age:number) {
    this.name = name;
    this.type = type;
    this.age = age;
  }

  static changeName1(animal:Animal) {
    animal.name = 'Black';
  }
  static changeAge1(animal:Animal) {
    animal.age += 1;
  }
}

@Entry
@Component
struct Demo1 {
  @Provide dog:Animal = new Animal('WangCai', 'dog', 2);

  changeAge2(animal:Animal) {
    animal.age += 2;
  }

  build() {
    Column({ space:10 }) {
      Text(`Demo1: This is a ${this.dog.age}-year-old ${this.dog.type} named ${this.dog.name}.`)
        .fontColor(Color.Red)
        .fontSize(30)
      Button('changeAge1')
        .onClick(()=>{
          // 通过赋值添加 Proxy 代理
          let a1 = this.dog;
          Animal.changeAge1(a1);
        })
      Button('changeAge2')
        .onClick(()=>{
          // 通过赋值添加 Proxy 代理
          let a2 = this.dog;
          this.changeAge2(a2);
        })
      Demo2()
    }
  }
}

@Component
struct Demo2 {

  build() {
    Column({ space:10 }) {
      Text(`Demo2.`)
        .fontColor(Color.Blue)
        .fontSize(30)
      Demo3()
    }
  }
}

@Component
struct Demo3 {
  @Consume dog:Animal;

  changeName2(animal:Animal) {
    animal.name = 'White';
  }

  build() {
    Column({ space:10 }) {
      Text(`Demo3: This is a ${this.dog.age}-year-old ${this.dog.type} named ${this.dog.name}.`)
        .fontColor(Color.Pink)
        .fontSize(30)
      Button('changeName1')
        .onClick(()=>{
          // 通过赋值添加 Proxy 代理
          let b1 = this.dog;
          Animal.changeName1(b1);
        })
      Button('changeName2')
        .onClick(()=>{
          // 通过赋值添加 Proxy 代理
          let b2 = this.dog;
          this.changeName2(b2);
        })
    }
  }
}