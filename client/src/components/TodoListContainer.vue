<script setup>
import { ref } from 'vue';

const API_URL = "http://localhost:8000/api";

document.addEventListener("DOMContentLoaded", async function() {

    let response = await fetch(API_URL);
    response.json().then(jsonData => {
        console.log(jsonData.tasks);
    });

    let postResponse = await fetch(API_URL, {
        method: "POST",
        body: JSON.stringify({"from": 86})
    });
    postResponse.json().then(jsonData => {
        console.log(jsonData.task);
    });
});


let tasksAreLoading = ref(false);
let tasks = ref([]);

async function getTasks() {
    tasksAreLoading.value = true;

    let response = await fetch(API_URL);
    response.json().then(jsonData => {
        tasksAreLoading.value = false;
        tasks.value = jsonData.tasks;
    }).catch(error => {
        tasksAreLoading.value = false;
        console.log(error);
    });
}

getTasks();

</script>
<template>
    <template v-if="tasksAreLoading">
        <h1>loading...</h1>
    </template>
    <template v-else>
        <ul>
            <li v-for="task in tasks" :key="task">{{ task }}</li>
        </ul>
    </template>
</template>

