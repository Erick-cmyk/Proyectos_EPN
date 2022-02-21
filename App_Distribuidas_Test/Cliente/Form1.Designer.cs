namespace Cliente
{
    partial class Pokedex
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Pokedex));
            this.pLogin = new System.Windows.Forms.Panel();
            this.pPokemon = new System.Windows.Forms.Panel();
            this.textBox3 = new System.Windows.Forms.TextBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.tbPokemon = new System.Windows.Forms.TextBox();
            this.btDebilidad = new System.Windows.Forms.Button();
            this.btType = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.tbPass = new System.Windows.Forms.TextBox();
            this.tbNombre = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.btValidar = new System.Windows.Forms.Button();
            this.pLogin.SuspendLayout();
            this.pPokemon.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // pLogin
            // 
            this.pLogin.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("pLogin.BackgroundImage")));
            this.pLogin.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.pLogin.Controls.Add(this.pPokemon);
            this.pLogin.Controls.Add(this.groupBox1);
            this.pLogin.Controls.Add(this.btValidar);
            this.pLogin.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pLogin.Location = new System.Drawing.Point(0, 0);
            this.pLogin.Margin = new System.Windows.Forms.Padding(2);
            this.pLogin.Name = "pLogin";
            this.pLogin.Size = new System.Drawing.Size(566, 319);
            this.pLogin.TabIndex = 6;
            // 
            // pPokemon
            // 
            this.pPokemon.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("pPokemon.BackgroundImage")));
            this.pPokemon.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.pPokemon.Controls.Add(this.textBox3);
            this.pPokemon.Controls.Add(this.textBox2);
            this.pPokemon.Controls.Add(this.label3);
            this.pPokemon.Controls.Add(this.tbPokemon);
            this.pPokemon.Controls.Add(this.btDebilidad);
            this.pPokemon.Controls.Add(this.btType);
            this.pPokemon.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pPokemon.Location = new System.Drawing.Point(0, 0);
            this.pPokemon.Margin = new System.Windows.Forms.Padding(2);
            this.pPokemon.Name = "pPokemon";
            this.pPokemon.Size = new System.Drawing.Size(566, 319);
            this.pPokemon.TabIndex = 8;
            this.pPokemon.Visible = false;
            this.pPokemon.Paint += new System.Windows.Forms.PaintEventHandler(this.pPokemon_Paint);
            // 
            // textBox3
            // 
            this.textBox3.Location = new System.Drawing.Point(263, 139);
            this.textBox3.Margin = new System.Windows.Forms.Padding(2);
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new System.Drawing.Size(195, 20);
            this.textBox3.TabIndex = 5;
            // 
            // textBox2
            // 
            this.textBox2.Location = new System.Drawing.Point(263, 224);
            this.textBox2.Margin = new System.Windows.Forms.Padding(2);
            this.textBox2.Name = "textBox2";
            this.textBox2.ReadOnly = true;
            this.textBox2.Size = new System.Drawing.Size(195, 20);
            this.textBox2.TabIndex = 4;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(68, 48);
            this.label3.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(159, 13);
            this.label3.TabIndex = 3;
            this.label3.Text = "Escriba el nombre del Pokemon:";
            // 
            // tbPokemon
            // 
            this.tbPokemon.Location = new System.Drawing.Point(263, 48);
            this.tbPokemon.Margin = new System.Windows.Forms.Padding(2);
            this.tbPokemon.Name = "tbPokemon";
            this.tbPokemon.Size = new System.Drawing.Size(195, 20);
            this.tbPokemon.TabIndex = 2;
            // 
            // btDebilidad
            // 
            this.btDebilidad.Location = new System.Drawing.Point(71, 208);
            this.btDebilidad.Margin = new System.Windows.Forms.Padding(2);
            this.btDebilidad.Name = "btDebilidad";
            this.btDebilidad.Size = new System.Drawing.Size(110, 50);
            this.btDebilidad.TabIndex = 1;
            this.btDebilidad.Text = "Debilidad";
            this.btDebilidad.UseVisualStyleBackColor = true;
            this.btDebilidad.Click += new System.EventHandler(this.btDebilidad_Click);
            // 
            // btType
            // 
            this.btType.Location = new System.Drawing.Point(71, 123);
            this.btType.Margin = new System.Windows.Forms.Padding(2);
            this.btType.Name = "btType";
            this.btType.Size = new System.Drawing.Size(110, 50);
            this.btType.TabIndex = 0;
            this.btType.Text = "Tipo de Pokemon";
            this.btType.UseVisualStyleBackColor = true;
            this.btType.Click += new System.EventHandler(this.btType_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.Transparent;
            this.groupBox1.Controls.Add(this.tbPass);
            this.groupBox1.Controls.Add(this.tbNombre);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.groupBox1.Location = new System.Drawing.Point(31, 38);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(2);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(2);
            this.groupBox1.Size = new System.Drawing.Size(274, 121);
            this.groupBox1.TabIndex = 7;
            this.groupBox1.TabStop = false;
            // 
            // tbPass
            // 
            this.tbPass.Location = new System.Drawing.Point(99, 71);
            this.tbPass.Margin = new System.Windows.Forms.Padding(2);
            this.tbPass.Name = "tbPass";
            this.tbPass.Size = new System.Drawing.Size(145, 20);
            this.tbPass.TabIndex = 4;
            // 
            // tbNombre
            // 
            this.tbNombre.Location = new System.Drawing.Point(99, 32);
            this.tbNombre.Margin = new System.Windows.Forms.Padding(2);
            this.tbNombre.Name = "tbNombre";
            this.tbNombre.Size = new System.Drawing.Size(145, 20);
            this.tbNombre.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(31, 71);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(64, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Contraseña:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(48, 32);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(47, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Nombre:";
            // 
            // btValidar
            // 
            this.btValidar.Location = new System.Drawing.Point(435, 237);
            this.btValidar.Margin = new System.Windows.Forms.Padding(2);
            this.btValidar.Name = "btValidar";
            this.btValidar.Size = new System.Drawing.Size(85, 37);
            this.btValidar.TabIndex = 6;
            this.btValidar.Text = "Validar";
            this.btValidar.UseVisualStyleBackColor = true;
            this.btValidar.Click += new System.EventHandler(this.btValidar_Click);
            // 
            // Pokedex
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(566, 319);
            this.Controls.Add(this.pLogin);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(2);
            this.Name = "Pokedex";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.pLogin.ResumeLayout(false);
            this.pPokemon.ResumeLayout(false);
            this.pPokemon.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pLogin;
        private System.Windows.Forms.Panel pPokemon;
        private System.Windows.Forms.Button btDebilidad;
        private System.Windows.Forms.Button btType;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox tbPass;
        private System.Windows.Forms.TextBox tbNombre;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btValidar;
        private System.Windows.Forms.TextBox textBox3;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox tbPokemon;
    }
}

