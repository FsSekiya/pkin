<template>
  <div>
    <div class="person-header">
      <p class="pull-left">
        <img src="http://placeimg.com/160/160/people" alt="User Image" class="img-circle image-90">
      </p>
      <p class="person-name">{{ member.name }}</p>
    </div>
    <table>
      <tr>
        <td>所属: {{ member.branch_name }} 支店</td>
        <td>現住所: {{ member.address }}</td>
      </tr>
      <tr>
        <td>従業員ID: {{ member.uid }}</td>
        <td></td>
      </tr>
      <tr>
        <td>入社年月日: {{ member.entrance_date }}</td>
        <td>電話番号: {{ member.phone_number }}</td>
      </tr>
      <tr>
        <td>時給: {{ member.hourly_pay }}</td>
        <td>メールアドレス: {{ member.email }}</td>
      </tr>
      <tr>
        <td>生年月日: {{ member.birthday }}</td>
        <td>銀行口座: {{ member.bank_account }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
  export default {
    components: {
    },
    props: [
      'member',
    ],
    data: function () {
      return {}
    },
    created: function () {
    },
    methods: {
      sample: function() {
      }
    }
  }
</script>
