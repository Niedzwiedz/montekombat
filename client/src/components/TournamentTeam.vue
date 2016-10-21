<template>
  <tr>
    <td> {{ team.name }} </td>
  </tr>
</template>

<script>
  export default {
    props: {
      team: Object
    }
  }
</script>
