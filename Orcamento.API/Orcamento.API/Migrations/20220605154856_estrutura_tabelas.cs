using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Orcamento.API.Migrations
{
    public partial class estrutura_tabelas : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Orcamentos",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Data = table.Column<DateTime>(type: "TEXT", nullable: false),
                    Descricao = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Orcamentos", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "ItensOrcamento",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    OrcamentoId = table.Column<int>(type: "INTEGER", nullable: false),
                    Local = table.Column<string>(type: "TEXT", maxLength: 100, nullable: true),
                    Telefone = table.Column<string>(type: "TEXT", maxLength: 16, nullable: true),
                    ResponsavelOrcamento = table.Column<string>(type: "TEXT", maxLength: 30, nullable: true),
                    Valor = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    Descricao = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ItensOrcamento", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ItensOrcamento_Orcamentos_OrcamentoId",
                        column: x => x.OrcamentoId,
                        principalTable: "Orcamentos",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ItensOrcamento_OrcamentoId",
                table: "ItensOrcamento",
                column: "OrcamentoId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ItensOrcamento");

            migrationBuilder.DropTable(
                name: "Orcamentos");
        }
    }
}
