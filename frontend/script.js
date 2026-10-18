const firstNumber = document.querySelector("#num1");
const secondNumber = document.querySelector("#num2");
const calculate = document.querySelector("#btn1");
const result = document.querySelector("#result1");

calculate.addEventListener("click", () => {
    let summarize = 0;
    summarize = Number(firstNumber.value) + Number(secondNumber.value);
    result.textContent = summarize;
})

const zhuptaq = document.querySelector("#input2");
const check = document.querySelector("#btn2");
const result2 = document.querySelector("#result2");

check.addEventListener("click", () => {
    const zhuptaqValue = zhuptaq.value;
    if (zhuptaqValue % 2 === 0) {
        result2.textContent = "This num is zhup"
    } else {
        result2.textContent = "This num is taq"
    }
})

const findMax = document.querySelector("#input3");
const max = document.querySelector("#btn3");
const result3 = document.querySelector("#result3");

max.addEventListener("click", () => {
  const arr = findMax.value.split(",").map(Number);
  result3.textContent = Math.max(...arr);
})

const wordInput = document.querySelector("#input4");
const changeBtn = document.querySelector("#btn4");
const result4 = document.querySelector("#result4");

changeBtn.addEventListener("click", () => {
    const arr = wordInput.value.split("").map(String);
    result4.textContent = arr.reverse().join("");
})

const word = document.querySelector("#input5");
const check5 = document.querySelector("#btn5");
const result5 = document.querySelector("#result5");

check5.addEventListener("click", () => {
    const arr = word.value.split("").map(String);
    const vowels = ["a", "e", "o", "i", "u"]
    const vowel = arr.filter((letter) => vowels.includes(letter)).length;
    result5.textContent = vowel;
})

const factorial = document.querySelector("#input6");
const btn6 = document.querySelector("#btn6");
const result6 = document.querySelector("#result6");

btn6.addEventListener("click", () => {
    let sum = 1;
    for (let i = 1; i <= factorial.value; i++) {
        sum *= i;
    }
    result6.textContent = sum;
})

const input7 = document.querySelector("#input7");
const btn7 = document.querySelector("#btn7");
const result7 = document.querySelector("#result7");

btn7.addEventListener("click", () => {
    const arr = input7.value.split("").map(String);
    const reverse = arr.reverse().join("");
    if (reverse === input7.value) {
        result7.textContent = "Palindrome!"
    } else {
        result7.textContent = "Not palindrome"
    }
})

const input8 = document.querySelector("#input8");
const btn8 = document.querySelector("#btn8");
const result8 = document.querySelector("#result8");

btn8.addEventListener("click", () => {
    const arr = input8.value.split(" ").map(String);
    const split = arr.map((word) => word[0].toUpperCase() + word.slice(1));
    result8.textContent = split.join(" ");
})

const inp9 = document.querySelector("#input9");
const btn9 = document.querySelector("#btn9");
const result9 = document.querySelector("#result9");

btn9.addEventListener("click", () => {
    let nums = 0;
    const arr = inp9.value.split(",").map(Number);
    for (let i = 0; i < arr.length; i++) {
        nums += arr[i];
    }
    result9.textContent = nums;
})

const inp10 = document.querySelector("#input10");
const btn10 = document.querySelector("#btn10");
const result10 = document.querySelector("#result10");

btn10.addEventListener("click", () => {
    const fahrenheit = (inp10.value * 2) + 30;
    result10.textContent = fahrenheit;
})


//FINALLY SECOND TASK HAHAHA
const hint = document.querySelector("#hint");
const load = document.querySelector("#loadBtn");
const statusData = document.querySelector("#status");
const posts = document.querySelector("#posts");

async function getData() {
    statusData.textContent = "Loading..."
    try {
    const promise = await fetch("https://jsonplaceholder.typicode.com/posts");
    const data = await promise.json();
        load.addEventListener("click", () => {
        posts.innerHTML = ''; 
        for (let i = 0; i < data.length; i++) {
        const post = document.createElement("div");
        post.className = 'post';
        post.innerHTML = `
        <p><b>UserId:</b>${data[i].userId}</p><br>
        <p><b>Id:</b>${data[i].id}</p><br>
        <p><b>Title:</b>${data[i].title}</p><br>
        <p><b>Body:</b>${data[i].body}</p><br>
        `

        posts.appendChild(post);
        }
        statusData.textContent = "Loaded!"
    })
    } catch(err) {
        alert(err)
    }
}

getData();