/**
 * @Provide和@Consume
 * 应用于与后代组件的双向数据同步，应用于状态数据在多个层级之间传递的场景
 *
 * 父子组件之间通过命名参数机制传递，@Provide 和 @Consume摆脱参数传递机制的束缚，
 * 实现跨层级传递
 *
 * 其中@Provide装饰的变量是在祖先组件中，可以理解为被”提供“给后代的状态变量
 * @Consume装饰的变量是在后代组件中，去”消费（绑定）“祖先组件提供的变量。
 *
 */



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
struct Demo1 { // 爷爷辈
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
struct Demo2 { // 父亲辈

  build() {
    Column({ space:10 }) {
      Text(`Demo2.`) // 父亲名字叫demo2
        .fontColor(Color.Blue)
        .fontSize(30)
      Demo3() // 生了一个儿子demo3
    }
  }
}

@Component
struct Demo3 {  // 孙子辈
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