<template>
    <div>
        <p> {{ match.team_1.name }} vs. {{ match.team_2.name }}  --  status: {{ match.status }} </p>
    </div>
</template>

<script>
  export default {
    props: {
      match: {}
    }
  }
</script>
