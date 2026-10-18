const task = document.querySelector(".task");
const add = document.querySelector(".add");
const tasks = document.querySelector(".tasks");

async function getList() {
    const res = await fetch('http://localhost:3004/list');
    const data = await res.json();
    data.forEach(task => {
        show(task.title, task.id);
    });
}

async function show(a, id) {
    const contain = document.createElement("div");
    contain.className = 'contain';
    contain.innerHTML = `
    <p>Your new task is: <b>${a}</b></p>
    <button class="edit">Edit</button>
    <button class="delete">Delete</button>
    `;

    tasks.appendChild(contain);

    const remove = contain.querySelector(".delete");
    remove.addEventListener("click", async () => {
        const res = await fetch('http://localhost:3004/delete', {
            method: "DELETE",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({id: id})
        });

        const result = await res.json();

        if (res.ok) {
            alert(result.message);
            contain.remove();
        } else {
            alert(result.error);
        }
    })

    const edit = contain.querySelector(".edit");
    edit.addEventListener("click", async () => {
        const edited = prompt("Enter your new task", a);
        if (!edited) return;
        const res = await fetch('http://localhost:3004/edit', {
            method: "PUT",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({id: id, title: edited, completed: false})
        })

        const result = await res.json();

        if (res.ok) {
            alert(result.message);
            contain.querySelector("p").innerHTML = `Your new task is: <b>${edited}</b>`
        } else {
            alert(result.error);
        }
    })
}

add.addEventListener("click", async () => {
    const title = task.value.trim();
    if (!title) return;

    const res = await fetch("http://localhost:3004/post", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ title })
    });

    const result = await res.json();

    if (res.ok) {
        alert(result.message);
        show(result.todo.title, result.todo.id); 
        task.value = ""; 
    } else {
        alert(result.error);
    }
});


getList();