<template>
  <div class="row" style="width: 260px;">
    <b-input class="col-6" id="inlineFormInputName2" v-bind:placeholder="balance.toString(10)" v-show="isInput"/>
    <p class="col-6 mt-2 mb-0" v-show="!isInput">{{ balance }}</p>
    <span class="offset-2 col-4 btn btn-primary" @click="isInput=!isInput" :class="{'btn-danger' : isInput}">{{ isInput ? '変更送信' : '残高変更' }}</span>
  </div>
</template>

<script>
  export default {
    props: [
      'currentStatus',
    ],
    data () {
      return {
        balance: 1030000,
        isInput: false
      }
    },
    mount: function () {
    },
    methods: {
    }
  }
</script>

