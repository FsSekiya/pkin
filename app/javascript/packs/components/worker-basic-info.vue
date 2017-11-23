<template>
  <div>
    <div class="person-header">
      <p class="pull-left">
        <img src="http://placeimg.com/160/160/people" alt="User Image" class="img-circle image-90">
      </p>
      <p class="person-name">{{ worker.name }}</p>
    </div>
    <table>
      <tr>
        <td>所属: {{ worker.branch_name }} 支店</td>
        <td>現住所: {{ worker.address }}</td>
      </tr>
      <tr>
        <td>従業員ID: {{ worker.uid }}</td>
        <td></td>
      </tr>
      <tr>
        <td>入社年月日: {{ worker.entrance_date }}</td>
        <td>電話番号: {{ worker.phone_number }}</td>
      </tr>
      <tr>
        <td>時給: {{ worker.hourly_pay }}</td>
        <td>メールアドレス: {{ worker.email }}</td>
      </tr>
      <tr>
        <td>生年月日: {{ worker.birthday }}</td>
        <td>銀行口座: {{ worker.bank_account }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
  export default {
    components: {
    },
    props: [
      'worker',
    ],
    data: function () {
      return {}
    },
    created: function () {
    },
    methods: {
    }
  }
</script>
