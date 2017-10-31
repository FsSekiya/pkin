<template>
  <table class="table table-striped table-hover">
    <tbody>
      <tr>
        <th>ID</th>
        <th>名前</th>
        <th>所属</th>
        <th>時給</th>
      </tr>
      <tr v-for="col in member_list">
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
    }
  }
  </script>

<style scoped>
</style>
