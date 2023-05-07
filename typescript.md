# Notes on TypeScript

## Installing

### Current

```shell
npm i -g typescript
```


### Older

In addition to installing locally for a project, I installed TypeScript globally:

```zsh
npm i -g typescript
```

This was prompted because I'm using the [typescript-vim](https://github.com/leafgarland/typescript-vim) plugin, which has a make command that depends on a globally-installed version of `tsc`.

I installed the plugin as usual with [vim-plug](https://github.com/junegunn/vim-plug).

I might have been able to override the `tsc` config using this in my `.vimrc`:
```
autocmd FileType typescript :set makeprg=node_modules/bin/tsc
```

I haven't tested it.


## Initializing a project

Initialize:

```shell
tsc --init
```

Then make a `src` and a `build` dir (or whichever project layout you prefer). Then edit `tsconfig.json` to set `rootDir` and `outDir`:
```
  ...
  "rootDir": "./src",
  ...
  "outDir": "./build",
  ...
```

Now, running `tsc` with no arguments will work.


## Migrating a React project

To migrate a React app created with [create-react-app](https://github.com/facebook/create-react-app) to [TypeScript](https://www.typescriptlang.org/) is fairly simple. These instructions are mostly from this article on [Adding TypeScript](https://create-react-app.dev/docs/adding-typescript/) to a React app. If creating a fresh project, make sure that you don't have a globally installed version of `create-react-app`. If so, uninstall it and use npx -- `npx create-react-app app-name --template typescript`.

### 1. Install TypeScript and dependencies

I added the installation of `react-router-dom` since I'm using it:
```bash
npm install --save typescript @types/node @types/react @types/react-dom @types/jest @types/react-router-dom
```

### 2. Rename source files

One by one I renamed source files from `.js` to `.tsx` and restarted the server between each. First:
```zsh
mv src/app.js src/app.tsx
npm start
```

### 3. Fix errors that arise

There were the obvious things like declaring types for arguments in function
definitions. I used `any` for a few types while I get more acquainted with
TypeScript.


#### Destructuring function parameters with defaults

In one case, I was doing destructuring of function parameters, and ran into the
somewhat clunky syntax to specify default parameters with destructuring:

```typescript
// Destructured with no typing
function fn({ p1, p2 }) {
  // ...
}

// Destructured with types
function fn({ p1, p2 }: { p1: number, p2: string }) {
  // ...
}

// Destructured with types and default values
function fn({ p1 = 123, p2 = "foo" }: { p1?: number, p2?: string }) {
  // ...
}
```

It's not too far off from Javascript's general clunkiness with destructuring
with default values and null checks. This may suggest the need to define a type
or interface for the parameter type in this case.


#### Function components and hooks

In order to migrate properly, I found I needed to move to primarily function
components and use [React Hooks](https://reactjs.org/docs/hooks-intro.html).

So some examples of moving to functions and hooks:
```TypeScript
// From
class MyComp extends Component {
  constructor(props) {
    super(props);
    this.state = {
      someState: 123,
    };
  }

  someHandler() {
    this.setState({someState: this.state.someState + 456});
  }

  // ...
}

// To
type Props = {
  p1: number;
  // ...
};

const MyComp = (props: Props) => {
  const [ someState, setSomeState ] = useState(123);

  const someHandler = () => {
    setSomeState(someState + 456);
  }

  // ...
}
```

Syntactically, in some cases there's a bit less repetition which is nice.


#### React-router-dom

I had to install `@types/react-router-dom` to move to using a history hook
instead of relying on history in the props:

```TypeScript
// From
this.props.history.push('/path');

// To:
import { useHistory } from 'react-router-dom';
// ...
let history = useHistory();
history.push('/path');
```


#### Use of children

To use `props.children`, you have to declare its type:

```TypeScript
type Props = {
  children: React.ReactNode;
};

export const StyledDiv = (props: Props) => {
  return (
    <div style={{ backgroundColor: '#123123' }} >
      {props.children}
    </div>
  );
}
```


#### Refs

When using refs with `useRef` like this:
```TypeScript
const aRef = useRef(null);

// ...

aRef.current.focus();
```

The compiler will complain that the ref may be null when using it. To correct
this you must cast the ref, and also check that it's non-null:

```TypeScript
const aRef = useRef<HTMLInputElement>(null);

// ...

if (aRef.current) {
  aRef.current.focus();
}
```

Be sure to cast to the proper element type. If the ref points to an audio
element, for example:
```TypeScript
const aRef = useRef<HTMLAudioElement>(null);

// ...

if (aRef.current) {
  aRef.current.play();
}
```


### Testing

TypeError: fsevents is not a function

```shell
npm install --save-dev fsevents
```

Error: Cannot find module 'nan'

```shell
npm install --save-dev nan
```


## Types

- number
- string
- boolean
- any
- unknown
- never
- tuple
- array
- enum

### Type Inference

Type inference works in obvious ways:

```typescript
let foo = 654_321;  // number
let bar = "qux";    // string
let baz = false;    // boolean
```

### Number

Underscore separation works, like in python, javascript (ES2021), etc:

```typescript
let foo: number = 654_321;
```

### String


### Boolean


### Any

Here, `foo` will have type `any`:

```typescript
let foo;
foo = 123;
foo = "456";
```

The value of static type checking is lost when using `any`, so it should be minimized.

```typescript
function foo(x) {   // Here, parameter `x` implicitly has an `any` type.
  console.log(x);
}
```

```typescript
function foo(x: any) {   // Now `x` is explicitly `any`
  console.log(x);
}
```

To disable the use of implicit `any` types, set `noImplicitAny` to `true` in the project's `tsconfig.json` (usually the default).


### Arrays

In Javascript, each element of an array can be of a different type:

```javascript
let arr = [10, '20', 30];
```

With a type annotation, this will cause an error:
```typescript
let arr: number[] = [10, '20', 30];  // Error
```

Type inference works here as well, so the type of `num_arr` is inferred to be `number[]`:

```typescript
let num_arr = [10, 20, 30];
num_arr.push(40);    // Fine
num_arr.push('50');  // Error
```

As before, with arrays (and `noImplicitAny` set to `false`), the type of an empty array will be inferred to be `any[]`:
```typescript
let arr4 = [];
```


### Tuples

Tuples are translated into javascript arrays.

```typescript
let record: [string, number] = ['foo', 123];
```


### Enums

The convention for enums is to use PascalCase.

A non-const enum:

```typescript
enum Color {
  Red,
  Green,
  Blue,
};

let aColor: Color = Color.Blue;
console.log("aColor = ", aColor);
```

This transpiles to this javascript:

```javascript
var Color;
(function (Color) {
    Color[Color["Red"] = 0] = "Red";
    Color[Color["Green"] = 1] = "Green";
    Color[Color["Blue"] = 2] = "Blue";
})(Color || (Color = {}));
let aColor = Color.Blue;
console.log("aColor = ", aColor);
```


Using a `const` enum will cause an optimization:

```typescript
const enum ConstColor {
  Red,
  Green,
  Blue,
};

let anotherColor: ConstColor = ConstColor.Blue;
console.log("anotherColor = ", anotherColor);
```

This generates less code:

```javascript
let anotherColor = 2;
console.log("anotherColor = ", anotherColor);
```


## Functions

Functions that return nothing have an implicit return type of `void`, but ideally the return type should always be explicitly declared.

```typescript
function logNumber(n: number): void {
  console.log("n = ", n);
}

logNumber(42);
```

### Unused parameters 

Unused parameters in a function will generate a warning and/or error, depending on the value of `noUnusedParameters` in `tsconfig.json`.

```typescript
function doStuff(x: number): number {
  return 123;
}
```

To explicitly declare that a function does not make use of a parameter, use an underscore (`_`):

```typescript
function doStuff(_: number): number {
  return 123;
}
```

See `noImplicitReturns` which controls whether code paths that do not return will include an implicit `return undefined`. 

See `noUnusedLocals` which controls whether unused local variables are allowed.


### Optional or Default parameters

A default value:

```typescript
function mul(a: number, b: number = 1): number {
  return a * b;
}

let n = mul(43, 65);
```


An optional parameter:

```typescript
function doSomething(a: number, b?: number): number {
  if (b) {
    return a + b;
  }
  return a + 2;
}

let n = doSomething(43);
```


## Objects

An example direct creation of an object with a readonly field:

```typescript
let record: {
  readonly id: number,
  name: string,
  readonly when: Date,
} = {
  id: 123,
  name: "Alice",
  when: new Date(),
};
```

With the declaration above, this will generate an error:

```typescript
record.id += 10;
```


## Type Aliases

`RecordType` is a type alias:

```typescript
type RecordType = {
  readonly id: number,
  name: string,
  when: Date,
  uselessFn: () => void,
}

let aRecord: RecordType = {
  id: 864,
  name: "Bob",
  when: new Date(),
  uselessFn: () => {
    console.log("Nothing interesting.");
  }
}
```


## Union Types

Union type example (and type narrowing):

```typescript
function logX(x: number | string) {
  if (typeof x === "number") {
    console.log("x: number = ", x);
  } else {
    console.log("x: string = ", x);
  }
}

logX(753);
logX("some string");
```


## Intersection Types

```typescript
type Type1 = {
  m1: () => void
};

type Type2 = {
  m2: () => void
};

type Type3 = Type1 & Type2;

let obj: Type3 = {
  m1: () => { console.log("Hi from m1")},
  m2: () => { console.log("Hi from m2")},
}
```


## Literal Types

```typescript
type EvensUnderTen = 2 | 4 | 6 | 8; 
let anEvenNum: EvensUnderTen = 4;
anEvenNum = 8; // Fine
anEvenNum = 3; // Error
```


## Nullable Types

`s` is defined as a union of `string` and `null`:

```typescript
function logUpper(s: string | null) {
  if (s) {
    console.log(s.toUpperCase());
  } else {
    console.log("no s");
  }
}

logUpper("some string");
logUpper(null);
```


## Optional Chaining

### Optional Property Access Operator

Here `getHoliday` can return a value of type `Holiday | null | undefined`, so callers have to handle those cases. To do this use the optional property access operator (`?` syntax).

```typescript
type Holiday = {
  when: Date,
}

function getHoliday(id: number): Holiday | null | undefined {
  return id === 0 ? null : { when: new Date() };
}

let h1 = getHoliday(0);
// console.log("h1 is on ", h1.when);  // Error: h1 could be null or undefined
console.log("h1 is on ", h1?.when);
let h2 = getHoliday(102030);
console.log("h2 is on ", h2?.when);
```

Another example where `when` is also an optional Date:

```typescript
type Holiday = {
  when?: Date,
}

let h1: Holiday | null | undefined = { when: new Date() };
console.log("h1 month: ", h1?.when?.getMonth());
console.log("h1 day: ", h1?.when?.getDay());
```

### Optional Element Access Operator

```typescript
let arr: number[] = [];
console.log("First element of arr = ", arr?.[0]);
```

### Optional Call Access Operator

```typescript
let someFunction: any = null;
someFunction?.('param');
```


## Class Access Modifiers

- `public` (implied)
- `private`
- `readonly`

```typescript
class SomeClass {
  // `public` is implicit
  someProp: number;
  readonly otherProp: string;
  private thirdProp: number;

  constructor(someProp: number, otherProp: string) {
    this.someProp = someProp;
    this.otherProp = otherProp;
    this.thirdProp = 2 * someProp;
  }
}

const x = new SomeClass(123, "foo");
x.someProp *= 10;
x.otherProp = "bar";       // Error
console.log(x.thirdProp);  // Error
```

Shorthand notation for defining a class, which works if all access modifiers
are explicitly specified:

```typescript
class SomeClass {
  constructor(
    public someProp: number,
    readonly otherProp: string,
  ) {}
}
```

The same with `thirdProp` initialized separately:

```typescript
class SomeClass {
  private thirdProp: number;
  constructor(
    public someProp: number,
    readonly otherProp: string
  ) {
    this.thirdProp = 2 * this.someProp;
  }
}
```


## Interfaces

An interface and an object that implements it:

```typescript
interface IsShape {
  name: string;
  numSides: number;
  perimeter(sideLength: number): number;
  area(sideLength: number): number;
}

const square: IsShape = {
  name: "square",
  numSides: 4,
  perimeter(sideLength: number): number {
    return this.numSides * sideLength;
  },
  area(sideLength: number): number {
    return sideLength * sideLength;
  },
};

console.log("Area of a square with side length 7: ", square.area(7));
```

A class that implements the interface:

```typescript
class SomeShapeClass implements IsShape {
  name: string;
  numSides: number;
  color: string;

  constructor (
    name: string,
    numSides: number,
    color: string,
  ) {
    this.name = name;
    this.numSides = numSides;
    this.color = color;
  }

  perimeter(sideLength: number): number {
    return this.numSides * sideLength;
  }

  area(sideLength: number): number {
    return sideLength * sideLength;
  }

  toString(): string {
    return `Shape: ${this.name}, ${this.numSides} sides, color: ${this.color}`;
  }
}

const blueTriangle = new SomeShapeClass("triangle", 3, "blue");
console.log(blueTriangle.toString());
```


