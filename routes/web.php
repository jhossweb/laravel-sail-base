<?php

use App\Models\Example;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});


Route::get("/example/create", [Example::class, "create"]);
//Route::post("/example", [Example::class, "store"])->name("example.store");