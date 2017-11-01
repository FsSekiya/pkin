<template>
  <table class="table table-striped table-hover">
    <tbody>
      <tr>
        <th class="w40">　</th>
        <th>ID</th>
        <th>名前</th>
        <th>所属</th>
        <th>時給</th>
      </tr>
      <tr v-for="col in member_list">
        <td class="text-center border c-p" v-on:click="sample">
          <i class="fa fa-plus"></i>
        </td>
        <td>
          {{ col.id }}
        </td>
        <td>
          {{ col.name }}
        </td>
        <td>
          {{ col.department }}
        </td>
        <td>
          {{ col.hourly_pay }}円
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
  import axios from 'axios'
  var tokens = document.getElementsByName('csrf-token')
  if (tokens.length) {
    axios.defaults.headers['X-CSRF-Token'] = tokens.item(0).content
  }
  export default {
    props: [
      'memberList',
    ],
    data: function () {
      return {
        member_list: []
      }
    },
    created: function () {
      this.member_list = JSON.parse(this.memberList)
    },
    methods: {
      sample: function() {
        var vm = this
        axios
          .get('/api/customer/sample') // dumb IE11 needs encode.
          .then((res) => {
            alert("owata")
          })
          .catch((res) => {
            alert("hazimatta")
          })
      }
    }
  }
</script>

<style scoped>
</style>
