const firstNumber = document.querySelector("#num1") as HTMLInputElement;
const secondNumber = document.querySelector("#num2") as HTMLInputElement;
const calculate = document.querySelector("#btn1") as HTMLButtonElement;
const result = document.querySelector("#result1") as HTMLElement;

calculate?.addEventListener("click", () => {
    let summarize = 0;
    summarize = Number(firstNumber.value) + Number(secondNumber.value);
    result.textContent = String(summarize);
})

const zhuptaq = document.querySelector("#input2") as HTMLInputElement;
const check = document.querySelector("#btn2") as HTMLButtonElement;
const result2 = document.querySelector("#result2") as HTMLElement;

check?.addEventListener("click", () => {
    const zhuptaqValue = Number(zhuptaq.value);
    if (zhuptaqValue % 2 === 0) {
        result2.textContent = "This num is zhup";
    } else {
        result2.textContent = "This num is taq";
    }
})

const findMax = document.querySelector("#input3") as HTMLInputElement;
const max = document.querySelector("#btn3") as HTMLButtonElement;
const result3 = document.querySelector("#result3") as HTMLElement;

max.addEventListener("click", () => {
  const arr = findMax.value.split(",").map(Number);
  result3.textContent = String(Math.max(...arr));
})

const wordInput = document.querySelector("#input4") as HTMLInputElement;
const changeBtn = document.querySelector("#btn4") as HTMLButtonElement;
const result4 = document.querySelector("#result4") as HTMLElement;

changeBtn.addEventListener("click", () => {
    const arr = wordInput.value.split("").map(String);
    result4.textContent = arr.reverse().join("");
})

const word = document.querySelector("#input5") as HTMLInputElement;
const check5 = document.querySelector("#btn5") as HTMLButtonElement;
const result5 = document.querySelector("#result5") as HTMLElement;

check5.addEventListener("click", () => {
    const arr = word.value.split("").map(String);
    const vowels = ["a", "e", "o", "i", "u"]
    const vowel = arr.filter((letter) => vowels.includes(letter)).length;
    result5.textContent = String(vowel);
})

const factorial = document.querySelector("#input6") as HTMLInputElement;
const btn6 = document.querySelector("#btn6") as HTMLButtonElement;
const result6 = document.querySelector("#result6") as HTMLElement;

btn6.addEventListener("click", () => {
    let sum = 1;
    for (let i = 1; i <= Number(factorial.value); i++) {
        sum *= i;
    }
    result6.textContent = String(sum);
})

const input7 = document.querySelector("#input7") as HTMLInputElement;
const btn7 = document.querySelector("#btn7") as HTMLButtonElement;
const result7 = document.querySelector("#result7") as HTMLElement;

btn7.addEventListener("click", () => {
    const arr = input7.value.split("").map(String);
    const reverse = arr.reverse().join("");
    if (reverse === input7.value) {
        result7.textContent = "Palindrome!"
    } else {
        result7.textContent = "Not palindrome"
    }
})

const input8 = document.querySelector("#input8") as HTMLInputElement;
const btn8 = document.querySelector("#btn8") as HTMLButtonElement;
const result8 = document.querySelector("#result8") as HTMLElement;

btn8.addEventListener("click", () => {
    // const inpValue = String(input8.value);
    // result8.textContent = inpValue.toLocaleUpperCase();
    const arr = input8.value.split(" ").map(String);
    const split = arr.map((word) => word[0]?.toUpperCase() + word.slice(1));
    result8.textContent = split.join(" ");
})

const inp9 = document.querySelector("#input9") as HTMLInputElement;
const btn9 = document.querySelector("#btn9") as HTMLButtonElement;
const result9 = document.querySelector("#result9") as HTMLElement;

btn9.addEventListener("click", () => {
    let nums = 0;
    const arr = inp9.value.split(",").map(Number); 
    for (const num of arr) {
        nums += num;
    }
    result9.textContent = String(nums);
})

const inp10 = document.querySelector("#input10") as HTMLInputElement;
const btn10 = document.querySelector("#btn10") as HTMLButtonElement;
const result10 = document.querySelector("#result10") as HTMLElement;

btn10.addEventListener("click", () => {
    const fahrenheit = (Number(inp10.value) * 2) + 30;
    result10.textContent = String(fahrenheit);
})


//FINALLY SECOND TASK HAHAHA
const load = document.querySelector("#loadBtn") as HTMLButtonElement;
const statusData = document.querySelector("#status") as HTMLParagraphElement;
const posts = document.querySelector("#posts") as HTMLElement;

    load.addEventListener("click", async () => {
    statusData.textContent = "Loading..."
    try {
    const promise = await fetch("https://jsonplaceholder.typicode.com/posts");
    const data = await promise.json();
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
        statusData.textContent = "Loaded!";
    } catch (err) {
        alert(err)
    }
    })