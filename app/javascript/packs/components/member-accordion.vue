<template>
  <table class="table table-striped table-hover">
    <tbody>
      <tr>
        <th class="w40">&nbsp;</th>
        <th>ID</th>
        <th>名前</th>
        <th>時給</th>
      </tr>
      <template v-for="(col, index) in member_list">
        <tr :key="col.id" v-on:click="collapsed.splice(index, 1, !collapsed[index])">
          <td>
            <i 
              class="fa"
              v-bind:class="{'fa-plus':collapsed[index], 'fa-minus':!collapsed[index]}" 
              aria-hidden="true"></i>
          </td>
          <td>{{ col.id }}</td>
          <td>{{ col.name }}</td>
          <td>{{ col.hourly_pay }}円</td>
        </tr>
        <tr v-show="!collapsed[index]" :key="col.id">
          <td colspan=5>
            <div class='accordion'>
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
        axios
          .get('/api/customer/sample')
          .then(() => {
            alert("owata")
          })
          .catch(() => {
            alert("hazimatta")
          })
      }
    }
  }
</script>

<style scoped>
</style>
