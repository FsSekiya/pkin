<template>
  <div class="dropdown">
    <button class="btn dropdown-toggle" :class="{'btn-danger': current_status == 0, 'btn-info': current_status == 1}" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      {{ current_status_labels[current_status] }}
    </button>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
      <div class="dropdown-item" @click="current_status=0">未振込</div>
      <div class="dropdown-item" @click="current_status=1">振込済</div>
    </div>
  </div>
</template>

<script>
  export default {
    props: [
      'currentStatus',
    ],
    data () {
      return {
        current_status: 0, // 0: 未振込, 1: 振込済
        current_status_labels: {0: '未振込', 1: '振込済'}
      }
    },
    mount: function () {
      this.current_status = this.currentStatus
    },
    methods: {
    }
  }
</script>

