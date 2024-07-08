<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    function create() {
        return view("products.create");
    }

    function store(Request $req) {
        $p = new Product;
        $p->name = $req->input("name");
        $p->save();

        return redirect()->to("/product");
    }
}
