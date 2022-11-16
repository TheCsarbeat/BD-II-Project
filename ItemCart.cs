using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Linq;

namespace indioSupermercado
{
    public class ItemCart
    {
        public int idLote;
        public string nameProduct;
        public int cant;
        public double precio;
        public double subTotal;
        public string picture;
        public string description;
        public int idSucursal;
        public int idProducto;
        public int idInventario;

        public ItemCart(int id, string name, int cant, double precio, string picture, string description, int s, int p, int inventario)
        {
            this.idLote = id;
            this.nameProduct = name;
            this.cant = cant;
            this.precio = precio;
            this.subTotal = precio * this.cant;
            this.picture = picture;
            this.description = description;
            this.idProducto = p;
            this.idSucursal = s;
            this.idInventario = inventario;
        }
        public int getIdProducto()
        {
            return this.idProducto;
        }
        public int getIdSucursal()
        {
            return this.idSucursal;
        }

        public string getNombre()
        {
            return this.nameProduct;
        }
        public string productName
        {
            get
            {
                return nameProduct;
            }
        }

        public int getId()
        {
            return this.idLote;
        }

        public int Id
        {
            get
            {
                return idLote;
            }
        }

        public string imgPath
        {
            get
            {
                return picture;
            }
        }

        public void addSameItem()
        {
            this.cant += 1;
            this.subTotal = this.precio * this.cant;

        }

        public string toString()
        {
            return this.nameProduct + " " + this.idLote.ToString() + " " + this.cant.ToString() + " " + this.subTotal;
        }

        public double getSubTotal()
        {
            return this.subTotal;
        }

        public double subTotalProduct
        {
            get
            {
                return subTotal;
            }
        }

        public string descriptonProduct
        {
            get
            {
                return description;
            }
        }

        public int cantProduct
        {
            get
            {
                return cant;
            }
        }

    }
}