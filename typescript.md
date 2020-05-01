# Notes on TypeScript

## Installing

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

npm install --save-dev fsevents

Error: Cannot find module 'nan'

npm install --save-dev nan

