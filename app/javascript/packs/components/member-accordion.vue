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
      <template v-for="(col, index) in member_list">
        <tr>
          <td>
            <i 
              class="fa"
              v-bind:class="{'fa-plus':collapsed[index], 'fa-minus':!collapsed[index]}" 
              aria-hidden="true" 
              v-on:click="collapsed.splice(index, 1, !collapsed[index])"></i>
          </td>
          <td>{{ col.id }}</td>
          <td>{{ col.name }}</td>
          <td>{{ col.department }}</td>
          <td>{{ col.hourly_pay }}円</td>
        </tr>
        <tr v-show="!collapsed[index]">
          <td colspan=5>
            <div>
              Hello
            </div>
          </td>
        </tr>
      </template>
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
      const member_list = JSON.parse(this.memberList)
      return {
        collapsed: new Array(member_list.length).fill(true),
        member_list: member_list
      }
    },
    created: function () {
    },
    methods: {
      sample: function() {
        var vm = this
        axios
          .get('/api/customer/sample')
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
