<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('municipios', function (Blueprint $table) {
            $table->id();

            $table->string("name", 100);
            $table->boolean("status");

            $table->unsignedBigInteger("departamento_id");
            $table->foreign("departamento_id")
                    ->references("id")
                    ->on("departamentos");

            $table->timestamps();
            $table->engine("InnoDB");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('municipios');
    }
};
