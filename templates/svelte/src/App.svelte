<script>
  export let name;
  export let age = 50;

  function incrementAge() {
    age++;
  }

  function decrementAge() {
    age--;
  }
</script>

<style>
  main {
    text-align: center;
    padding: 1em;
    max-width: 240px;
    margin: 0 auto;
  }

  h1 {
    color: #ff3e00;
    text-transform: uppercase;
    font-size: 4em;
    font-weight: 100;
  }

  @media (min-width: 640px) {
    main {
      max-width: none;
    }
  }
</style>

<h1>Hello {name}!</h1>
<p>Your age is {age}</p>

<button on:click="{incrementAge}">Increment</button>
<button on:click="{decrementAge}">Decrement</button>
